import * as React from 'react';
import * as ReactDOM from 'react-dom';

type ImageContainerProps = {
    className?: string;
    color?: string;
    style?: React.CSSProperties;
    image?: HTMLImageElement;
};

class ImageContainer extends React.Component<ImageContainerProps> {
    domNode: Element | Text;
    divComponent: React.RefObject<HTMLDivElement>;

    constructor(props: ImageContainerProps) {
        super(props);
        this.domNode = null;
        this.divComponent = React.createRef();
    }

    componentDidMount(): void {
        // eslint-disable-next-line react/no-find-dom-node
        this.domNode = ReactDOM.findDOMNode(this);
    }

    render(): React.ReactNode {
        return (
            <div className="image-container" ref={this.divComponent}>
                {this.props.image && (
                    <img src={this.props.image.src} alt="program generated" />
                )}
            </div>
        );
    }
}

export default ImageContainer;
